require 'find'

# 定义目标目录
POSTS_DIR = '_posts'

# 递归遍历目录
Find.find(POSTS_DIR) do |path|
  # 检查是否是文件且扩展名为.md
  if File.file?(path) && File.extname(path) == '.md'
    # 读取文件内容
    content = File.read(path)
    
    # 检查是否包含frontmatter
    if content =~ /^---\n(.*?)\n---/m
      frontmatter = $1
      # 替换category为categories: []
      updated_frontmatter = frontmatter.gsub(/\bcategory:\s*[^\n]+/, 'categories: []')
      # 替换tag为tags: []
      updated_frontmatter = updated_frontmatter.gsub(/\btag:\s*[^\n]+/, 'tags: []')
      # 替换categories和tags的其他形式
      updated_frontmatter = updated_frontmatter.gsub(/\bcategories:\s*[^\n]+/, 'categories: []')
      updated_frontmatter = updated_frontmatter.gsub(/\btags:\s*[^\n]+/, 'tags: []')
      # 确保frontmatter中包含categories和tags
      unless updated_frontmatter =~ /\bcategories:\s*\[\s*\]/
        updated_frontmatter += "\ncategories: []"
      end
      unless updated_frontmatter =~ /\btags:\s*\[\s*\]/
        updated_frontmatter += "\ntags: []"
      end
      # 生成新的内容
      new_content = content.sub(/^---\n(.*?)\n---/m, "---\n#{updated_frontmatter}\n---")
      # 写回文件
      File.write(path, new_content)
      puts "Updated frontmatter in: #{path}"
    end
  end
end

puts "Done!"

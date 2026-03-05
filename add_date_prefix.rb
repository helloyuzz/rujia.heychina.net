require 'find'

# 定义日期前缀
DATE_PREFIX = '1973-01-26-'
# 定义目标目录
POSTS_DIR = '_posts'

# 递归遍历目录
Find.find(POSTS_DIR) do |path|
  # 检查是否是文件且扩展名为.md
  if File.file?(path) && File.extname(path) == '.md'
    # 获取文件名
    filename = File.basename(path)
    # 检查文件名是否已经带有日期前缀
    unless filename =~ /^\d{4}-\d{2}-\d{2}-/
      # 构建新的文件名
      new_filename = DATE_PREFIX + filename
      # 构建新的文件路径
      new_path = File.join(File.dirname(path), new_filename)
      # 重命名文件
      File.rename(path, new_path)
      puts "Renamed: #{path} -> #{new_path}"
    end
  end
end

puts "Done!"

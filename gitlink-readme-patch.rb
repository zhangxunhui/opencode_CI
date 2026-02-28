# GitLink 修改补丁 - 创建项目后不自动生成 README.md
# 应用此补丁使 GitLink 行为与 Gitea 一致（创建空仓库）

# ============================================================================
# 补丁 1: app/models/project.rb
# 查找并注释掉创建项目后自动创建 README 的回调
# ============================================================================

# 在 app/models/project.rb 中查找类似代码：
#
# after_create :initialize_readme_file
# 或
# after_create :create_initial_commit
#
# 注释掉这些回调：
#
# after_create :initialize_readme_file  # 注释掉这行

# ============================================================================
# 补丁 2: app/services/create_project_service.rb (或类似服务文件)
# ============================================================================

# 查找创建 README 的方法并修改：
#
# 原代码：
# def create_readme_file(project, user)
#   content = "# #{project.name}\n\n#{project.description}"
#   project.create_file('README.md', content, user, 'Initial commit')
# end
#
# 修改为：
# def create_readme_file(project, user)
#   # 不创建 README 文件 - 创建空仓库
#   # content = "# #{project.name}\n\n#{project.description}"
#   # project.create_file('README.md', content, user, 'Initial commit')
#   return true
# end

# ============================================================================
# 补丁 3: app/controllers/projects_controller.rb
# 修改 create 方法
# ============================================================================

# 在 app/controllers/projects_controller.rb 的 create 方法中：
#
# 原代码可能类似：
# def create
#   @project = Project.new(project_params)
#   if @project.save
#     @project.initialize_readme(current_user)  # <-- 注释掉这行
#     redirect_to @project
#   end
# end
#
# 修改后：
# def create
#   @project = Project.new(project_params)
#   if @project.save
#     # @project.initialize_readme(current_user)  # 已注释 - 创建空仓库
#     redirect_to @project
#   end
# end

# ============================================================================
# 补丁 4: app/models/repository.rb (如果存在)
# ============================================================================

# 查找仓库初始化方法并修改：
#
# 原代码：
# def initialize_repository(owner)
#   create_file('README.md', default_readme_content, owner)
#   create_gitignore(default_gitignore, owner)
# end
#
# 修改为：
# def initialize_repository(owner)
#   # 创建空仓库 - 不添加任何文件
#   GitService.init_empty_repo(path)
# end

# ============================================================================
# 补丁 5: lib/tasks/init_readme.rb (如果存在独立任务文件)
# ============================================================================

# 如果 GitLink 使用独立的任务文件创建 README：
#
# 原代码：
# namespace :init do
#   desc "Create initial README for project"
#   task create_readme: :environment do
#     # ...
#   end
# end
#
# 修改为：
# namespace :init do
#   desc "Create initial README for project"
#   task create_readme: :environment do
#     # 已禁用 - 创建空仓库
#     # puts "README creation disabled"
#   end
# end

# ============================================================================
# 测试步骤
# ============================================================================

# 1. 应用补丁后重启 GitLink 服务
# 2. 创建测试项目验证：
#    - 项目创建后应显示空仓库
#    - 无 README.md 文件
#    - 提示"上传已有项目"或"初始化新文件"

# ============================================================================
# 回滚方案
# ============================================================================

# 如需回滚，取消注释上述代码即可恢复原有行为
# GitLink 项目创建后默认 README.md 修改方案

## 问题分析

**现状：** GitLink 创建项目后，仓库默认包含一个 README.md 文件

**目标：** 修改为创建项目后仓库为空（像 Gitea 一样）

## 需要修改的代码位置

### 后端修改 (forgeplus)

根据 Ruby on Rails 项目结构和 GitLink/Gitea 的架构，需要修改以下文件：

#### 1. 项目创建服务 - 主要修改点

**文件：** `app/services/create_project_service.rb` 或 `app/models/project.rb`

**修改内容：**
找到创建项目后初始化 README.md 的代码，通常在 `create` 或 `initialize_repository` 方法中。

**需要查找的代码模式：**
```ruby
# 查找类似这样的代码
create_readme_file
init_repo_with_readme
initialize_repository_with_default_files
```

**修改方式：**
```ruby
# 注释掉或删除创建 README 的代码
# create_readme_file(project, user)  # 注释这行
# 或者
def initialize_repository
  # 删除创建 README.md 的逻辑
  # create_file(@project, user, 'README.md', readme_content, 'Initial commit')
  @project.repository.empty = true
end
```

#### 2. 项目控制器 - 次要修改点

**文件：** `app/controllers/projects_controller.rb`

**查找：** `create` 方法中是否有调用初始化 README 的代码

**修改：**
```ruby
def create
  @project = Project.new(project_params)
  if @project.save
    # 注释掉初始化 README 的调用
    # @project.initialize_readme(current_user)
    redirect_to @project
  end
end
```

#### 3. 仓库模型 - 核心修改点

**文件：** `app/models/repository.rb` 或 `app/models/project.rb`

**查找：** 仓库初始化相关方法

**可能的方法名：**
- `create_readme`
- `init_repo`
- `initialize_empty_repo`
- `create_initial_commit`

**修改示例：**
```ruby
def initialize_repository(owner)
  # 原有代码创建 README.md
  # create_file('README.md', default_readme_content, owner)
  
  # 修改为创建空仓库
  GitService.init_empty_repo(path)
end
```

### 前端修改 (forgeplus-react)

#### 1. 新建项目页面

**文件：** `src/pages/projects/new.jsx` 或类似路径

**修改：** 移除任何关于"初始化 README"的选项或提示

### Gitea 对比参考

Gitea 的空仓库创建逻辑在：
- `routers/web/repo/create.go` - `createPost` 函数
- `services/repository/create.go` - `CreateRepository` 函数

Gitea **不**自动创建 README.md，这正是我们需要的行为。

## 测试步骤

### 1. 后端测试
```bash
cd forgeplus
bundle install
rails db:migrate
rails s
```

### 2. 前端测试
```bash
cd public/react
npm install
npm run build
```

### 3. 功能验证
1. 登录 GitLink 平台
2. 进入"创建项目"页面
3. 填写项目信息并提交
4. 验证创建后的项目页面：
   - ✅ 仓库应该为空（无文件）
   - ✅ 显示"上传已有项目"或"初始化新文件"的提示
   - ✅ 无 README.md 预览

## 部署步骤

### 1. 备份原代码
```bash
cd /path/to/gitlink
cp -r app app.backup.$(date +%Y%m%d)
```

### 2. 应用修改
将修改后的文件复制到 GitLink 安装目录

### 3. 重启服务
```bash
# 停止 sidekiq
killall sidekiq

# 停止 rails
killall rails

# 重启
cd /path/to/gitlink
bundle exec sidekiq -C config/sidekiq.yml -e production -d
rails s -e production
```

### 4. 验证部署
访问 GitLink 平台，创建测试项目验证修改效果

## 注意事项

1. **权限问题：** 确保修改后的代码有正确的文件访问权限
2. **数据库迁移：** 如果修改涉及数据库 schema，需要运行 `rails db:migrate`
3. **缓存清理：** 修改后清理 Rails 缓存 `rake tmp:cache:clear`
4. **回滚方案：** 保留备份代码以便快速回滚

## 参考文档

- Gitea 源码：https://github.com/go-gitea/gitea
- GitLink 部署文档：https://gitlink.org.cn/Gitlink/forgeplus/src/branch/master/README.md
- GitLink API 文档：https://www.gitlink.org.cn/docs/api

---

**修改日期：** 2026-02-27  
**修改原因：** 用户要求创建项目后仓库为空，便于上传已有项目
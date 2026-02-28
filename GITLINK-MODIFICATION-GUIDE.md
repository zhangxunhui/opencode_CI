# GitLink 修改指南 - 创建空仓库（移除自动 README.md）

## 问题描述

当前 GitLink 创建项目后会自动生成 README.md 文件，导致用户无法直接上传已有项目。

**目标：** 修改为创建项目后仓库为空（与 Gitea 行为一致）

## 修改方案

### 方案 1：修改 Project 模型（推荐）

**文件：** `app/models/project.rb`

**查找代码：**
```ruby
after_create :initialize_readme_file
# 或
after_create :create_initial_commit
```

**修改为：**
```ruby
# after_create :initialize_readme_file  # 注释掉 - 创建空仓库
```

### 方案 2：修改创建项目的服务

**文件：** `app/services/create_project_service.rb` 或 `app/models/repository.rb`

**查找方法：** `initialize_repository` 或 `create_readme_file`

**原代码示例：**
```ruby
def initialize_repository(owner)
  content = "# #{project.name}\n\n#{project.description}"
  create_file('README.md', content, owner, 'Initial commit')
end
```

**修改为：**
```ruby
def initialize_repository(owner)
  # 创建空仓库 - 不添加任何文件
  GitService.init_empty_repo(path)
  # 注释掉创建 README 的代码
  # create_file('README.md', content, owner, 'Initial commit')
end
```

### 方案 3：修改 Projects 控制器

**文件：** `app/controllers/projects_controller.rb`

**查找 create 方法：**

**原代码：**
```ruby
def create
  @project = Project.new(project_params)
  if @project.save
    @project.initialize_readme(current_user)  # <-- 注释这行
    redirect_to @project
  end
end
```

**修改为：**
```ruby
def create
  @project = Project.new(project_params)
  if @project.save
    # @project.initialize_readme(current_user)  # 已禁用 - 创建空仓库
    redirect_to @project
  end
end
```

## 测试步骤

### 1. 应用修改

```bash
cd /path/to/gitlink/forgeplus

# 备份原文件
cp app/models/project.rb app/models/project.rb.backup
cp app/services/create_project_service.rb app/services/create_project_service.rb.backup

# 应用修改（使用文本编辑器或 patch 命令）
```

### 2. 重启服务

```bash
# 停止现有服务
killall sidekiq
killall rails

# 重启
cd /path/to/gitlink/forgeplus
bundle exec sidekiq -C config/sidekiq.yml -e production -d
rails s -e production
```

### 3. 验证修改

1. 访问 GitLink 平台
2. 点击"创建项目"
3. 填写项目信息并提交
4. **预期结果：**
   - ✅ 仓库页面显示为空
   - ✅ 无 README.md 文件
   - ✅ 显示"上传文件"或"初始化仓库"选项

## Gitea 对比参考

Gitea 的空仓库创建逻辑位于：
- `routers/web/repo/create.go` - `createPost` 函数
- `services/repository/create.go` - `CreateRepository` 函数

Gitea **不**自动创建 README.md，这是标准行为。

## 注意事项

1. **数据库迁移：** 如果修改涉及 schema 变更，运行 `rails db:migrate`
2. **缓存清理：** `rake tmp:cache:clear`
3. **回滚方案：** 保留 `.backup` 文件以便快速恢复

## 相关文件位置

```
forgeplus/
├── app/
│   ├── models/
│   │   ├── project.rb              # 主要修改点
│   │   └── repository.rb           # 可能修改点
│   ├── services/
│   │   └── create_project_service.rb  # 主要修改点
│   └── controllers/
│       └── projects_controller.rb     # 可能修改点
└── lib/
    └── tasks/
        └── init_readme.rb          # 如果存在独立任务
```

## 补丁文件

已生成补丁文件：`gitlink-readme-patch.rb`

应用补丁：
```bash
cd /path/to/gitlink/forgeplus
patch -p1 < /path/to/gitlink-readme-patch.rb
```

## 联系支持

如有问题，参考 GitLink 文档或联系 CCF 技术支持。

---

**修改日期：** 2026-02-27  
**修改目的：** 使 GitLink 创建项目后仓库为空，便于用户直接上传已有项目
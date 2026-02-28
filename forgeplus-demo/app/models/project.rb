# =============================================================================
# GitLink Project Model - 演示修改版本
# =============================================================================
# 此文件演示了如何修改 GitLink 使创建项目后仓库为空（无 README.md）
# =============================================================================

class Project < ApplicationRecord
  # ==========================================================================
  # 原始代码 (修改前):
  # ==========================================================================
  # after_create :initialize_readme_file
  # after_create :create_initial_commit
  
  # ==========================================================================
  # 修改后代码 (已注释掉自动创建 README 的回调):
  # ==========================================================================
  # after_create :initialize_readme_file  # 已禁用 - 创建空仓库
  # after_create :create_initial_commit   # 已禁用 - 创建空仓库
  
  # ==========================================================================
  # 关联关系
  # ==========================================================================
  belongs_to :user
  belongs_to :repository, optional: true
  has_many :issues, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :commits, dependent: :destroy
  
  # ==========================================================================
  # 验证
  # ==========================================================================
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :description, length: { maximum: 500 }
  
  # ==========================================================================
  # 方法：初始化 README 文件 (原始版本)
  # ==========================================================================
  # def initialize_readme_file(user)
  #   content = "# #{self.name}\n\n#{self.description || 'No description'}"
  #   self.repository.create_file('README.md', content, user, 'Initial commit')
  #   self.repository.save!
  # end
  
  # ==========================================================================
  # 方法：初始化 README 文件 (修改版本 - 空仓库)
  # ==========================================================================
  def initialize_readme_file(user)
    # 已禁用 - 创建空仓库
    # 不再自动创建 README.md 文件
    # 用户可以自行上传或初始化
    Rails.logger.info "Project #{self.name} created with empty repository"
    true
  end
  
  # ==========================================================================
  # 方法：创建初始提交 (原始版本)
  # ==========================================================================
  # def create_initial_commit(user)
  #   self.repository.create_commit(
  #     message: 'Initial commit',
  #     files: [{'path' => 'README.md', 'content' => readme_content}],
  #     user: user
  #   )
  # end
  
  # ==========================================================================
  # 方法：创建初始提交 (修改版本 - 空仓库)
  # ==========================================================================
  def create_initial_commit(user)
    # 已禁用 - 不创建任何文件
    Rails.logger.info "Skipping initial commit for project #{self.name}"
    true
  end
  
  # ==========================================================================
  # 方法：仓库 URL
  # ==========================================================================
  def repository_url
    "https://www.gitlink.org.cn/#{user.username}/#{name}"
  end
  
  # ==========================================================================
  # 方法：转换为 JSON
  # ==========================================================================
  def as_json(options = {})
    super(options.merge({
      methods: [:repository_url],
      except: [:user_id, :created_at, :updated_at]
    }))
  end
end
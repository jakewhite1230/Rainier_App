class Project < ActiveRecord::Base
  belongs_to :tenant
  has_many :uploads, dependent: :destroy
  validate :free_plan_can_only_have_three_projects

  has_many :user_projects
  has_many :users, through: :user_projects
  scope :upcoming, -> {order(:expected_completion_date => :asc)}



	def free_plan_can_only_have_three_projects
		if self.new_record? && (tenant.projects.count > 3) && (tenant.plan == 'free') 
			errors.add(:base, "Free plans cannot have more than 3 projects")
		end
	end

	def self.by_user_plan_and_tenant(tenant_id)
		tenant = Tenant.find(tenant_id)
		if tenant.plan == "premium"
			tenant.projects
		else
			tenant.projects.order(:id).limit(3)
		end
	end

end

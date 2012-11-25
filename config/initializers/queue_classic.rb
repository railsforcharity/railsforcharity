ENV["QC_DATABASE_URL"] = "postgres://localhost/railsforcharity_development" if Rails.env.development?
ENV["QC_DATABASE_URL"] = "postgres://localhost/railsforcharity_test" if Rails.env.test?
# https://github.com/rails/rails/issues/26937
ActiveRecord::Base.connection.execute("SELECT setval('hands_id_seq', 1000);")

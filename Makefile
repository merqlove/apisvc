ifndef SERVER
	SERVER = production
endif

migrate:
	bundle exec rails db:create db:migrate

seed:
	bundle exec rails db:seed

doc_v1:
	rails api:v1:schema

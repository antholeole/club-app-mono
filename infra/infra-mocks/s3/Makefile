i: 
	sudo gem install fakes3

dev:
	S3_FAKE_LICENSE_KEY=$$(grep S3_FAKE_LICENSE_KEY ./../../../.env | cut -d '=' -f 2-) \
	fakes3 -r ./storage -p 9876 --license $$ADMIN_SECRET
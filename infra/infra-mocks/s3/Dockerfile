
FROM alpine:3.10
WORKDIR /fakes3_data
EXPOSE 8000
CMD ["fakes3", "server", "--root",  ".", "--port",  "9876", "--license", "8265190107"]


RUN apk add --no-cache ruby ruby-io-console ruby-webrick ruby-etc
RUN gem install fakes3 --no-doc

EXPOSE 9876

# to run with a non-root user, we need to manually create the workdir with the needed ownership
# and declare the VOLUME after the USER
RUN mkdir -p /fakes3_data && chown nobody:nobody /fakes3_data && chmod 0750 /fakes3_data 
USER nobody
VOLUME /fakes3_data
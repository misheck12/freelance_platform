FROM ruby:3.2.2

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install Node.js for ExecJS runtime
RUN apt-get update && apt-get install -y nodejs

# Add the rest of the application code
ADD . /usr/src/app/

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["rails", "s", "-b", "0.0.0.0"]

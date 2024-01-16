# Use the official Ruby image as the base
FROM ruby:3.2.2

# Install the required libraries and tools
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Create and set the working directory
RUN mkdir /myapp
WORKDIR /myapp

# Copy the Gemfile and install the gems
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install


# Copy the rest of the app files
COPY . /myapp

# Expose the port that the app runs on
EXPOSE 3000

# Run the entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

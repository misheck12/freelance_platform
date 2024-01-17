# Use the official Ruby image as the base
FROM ruby:3.2.2

# Install the required libraries and tools from the official repositories
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
RUN apt-get update -qq && apt-get install -y --no-install-recommends nodejs postgresql-client

# Create and set the working directory
WORKDIR /myapp

# Copy the Gemfile and install the gems
COPY Gemfile* /myapp/
RUN bundle install

# Copy the rest of the app files
COPY . /myapp

# Expose the port that the app runs on
EXPOSE 3000

# Run the entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Set the RAILS_ENV environment variable
ENV RAILS_ENV production

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

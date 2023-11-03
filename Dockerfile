# # Use a minimal web server image as the base image
# FROM nginx:alpine

# # Remove the default NGINX welcome page
# RUN rm -rf /usr/share/nginx/html/*

# # Install Git to clone the repository
# RUN apk update && apk add git

# # Clone your GitHub repository and copy the contents to the NGINX web server directory
# RUN git clone https://github.com/ChowdriS/docker.git /tmp/repo && \
#     mv /tmp/repo/* /usr/share/nginx/html/ && \
#     rm -rf /tmp/repo

# # Expose port 80
# EXPOSE 80

# # Start NGINX
# CMD ["nginx", "-g", "daemon off;"]





##################################################



# Use a Node.js base image
FROM node:14 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install project dependencies
RUN npm install

# Clone your GitHub repository (replace with your repo URL)
RUN git clone https://github.com/ChowdriS/Portfolio.git .

# Build the Next.js application
RUN npm run build

# Use a lightweight web server image to serve the application
FROM nginx:alpine

# Copy the build output from the previous stage
COPY --from=build /app/out /usr/share/nginx/html

# Expose port 80
EXPOSE 80

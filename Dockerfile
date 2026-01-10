# Node v24 Alpine
FROM node:24-alpine

# Install dependencies required for sharp and other build tools
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev git

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/app

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install pnpm and dependencies
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# Copy the rest of the application
COPY . .

# Build the Strapi application
RUN pnpm run build

# Expose the Strapi port
EXPOSE 1337

# Start the application
CMD ["pnpm", "run", "start"]

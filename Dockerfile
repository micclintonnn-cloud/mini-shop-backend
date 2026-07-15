FROM node:20-bookworm-slim

WORKDIR /app

# Copy workspace files first for better caching
COPY package*.json ./
COPY turbo.json ./
COPY apps/backend/package*.json ./apps/backend/

# Install dependencies
RUN npm ci

# Copy the rest of the repository
COPY . .

# Build only the backend workspace
RUN npm run build --workspace=@dtc/backend

EXPOSE 9000

WORKDIR /app/apps/backend

CMD ["npm", "start"]
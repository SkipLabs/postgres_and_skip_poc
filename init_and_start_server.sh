#!/bin/bash

# Colors and formatting
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Cleanup existing container if it exists
echo -e "\n${BLUE}${BOLD}🧹 Cleaning up existing containers...${NC}"
if docker ps -a | grep -q skip-demo-postgres; then
  echo -e "${YELLOW}Found existing container, removing...${NC}"
  docker stop skip-demo-postgres > /dev/null 2>&1 || true
  docker rm skip-demo-postgres > /dev/null 2>&1 || true
  echo -e "${GREEN}✓ Cleanup complete${NC}"
else
  echo -e "${GREEN}✓ No cleanup needed${NC}"
fi

echo -e "\n${BLUE}${BOLD}🐘 Starting PostgreSQL...${NC}"
docker run --name skip-demo-postgres \
  -e POSTGRES_USER=skipper \
  -e POSTGRES_PASSWORD=skipper123 \
  -e POSTGRES_DB=skipdb \
  -p 5432:5432 \
  -d postgres > /dev/null

echo -e "\n${YELLOW}⏳ Waiting for PostgreSQL to be ready...${NC}"
until docker exec skip-demo-postgres pg_isready -U skipper; do
  echo "PostgreSQL is unavailable - retrying..."
  sleep 2
done
echo -e "${GREEN}✨ PostgreSQL is up and running!${NC}\n"

echo -e "${BLUE}${BOLD}📦 Setting up database...${NC}"
docker cp src/db/schema.sql skip-demo-postgres:/schema.sql
docker exec -it skip-demo-postgres psql -U skipper -d skipdb -f /schema.sql > /dev/null
echo -e "${GREEN}✓ Schema loaded${NC}"

echo -e "\n${BLUE}${BOLD}👥 Checking user count...${NC}"
docker exec -it skip-demo-postgres psql -U skipper -d skipdb -c "SELECT COUNT(*) as user_count FROM users;"
echo -e "${GREEN}✓ Successfully verified user count${NC}"

echo -e "\n${BLUE}${BOLD}📦 Installing dependencies...${NC}"
pnpm add pg @types/pg > /dev/null 2>&1
echo -e "${GREEN}✓ Dependencies installed${NC}"

echo -e "\n${BLUE}${BOLD}🔨 Install and build TypeScript...${NC}"
pnpm install
pnpm build
echo -e "${GREEN}✓ Build complete${NC}"

echo -e "\n${GREEN}${BOLD}🚀 Starting server...${NC}\n"
pnpm start


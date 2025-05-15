# Skip Postgres Demo

A demonstration project showing how to use Skip's reactive data streaming with a PostgreSQL backend. This project implements a simple blog post system with real-time updates using Skip's streaming capabilities.

## Features

- Real-time post streaming using Skip's reactive data system
- PostgreSQL integration for data persistence
- RESTful API endpoints for post management
- Support for streaming data access

## Prerequisites

- [Node.js](https://nodejs.org/en) (Latest LTS version recommended)
- ['pnpm'](https://pnpm.io/) package manager
- [Docker](https://www.docker.com/) (for PostgreSQL)

## Setup

Merely run the script for that:
```bash
./init_and_start_server.sh
```

## API Endpoints

### Posts

- `GET /posts/:id` - Get a specific post
- `POST /posts` - Create a new post
- `PATCH /posts/:id/publish` - Publish a post
- `PATCH /posts/:id/unpublish` - Unpublish a post
- `DELETE /posts/:id` - Delete a post

### Users

- `GET /users` - List all users
- `GET /users/:id` - Get a specific user

### Streaming

- `GET /streams/posts` - Get a stream of all posts
- `GET /streams/posts/:uid` - Get a stream for a specific post

## Skip Integration

This project demonstrates Skip's reactive data capabilities:

- Real-time data streaming using Skip's service broker
- Automatic data synchronization between clients
- Efficient resource management with Skip's resource system

### Clean Up

To clean up the development environment:

```bash
pnpm clean
docker stop skip-demo-postgres && docker rm skip-demo-postgres
```

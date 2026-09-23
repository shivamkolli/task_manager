# Task Manager

A full-stack task management application built with **Ruby on Rails 8**, demonstrating modern Rails development practices including authentication, authorization, REST APIs, GraphQL, Hotwire, PostgreSQL, RSpec, and Docker.

The project is designed as a practical demonstration of building a **secure, maintainable, testable, and containerized Rails application**.

## ✨ Features

* User registration and authentication
* Session-based authentication
* Authorization for protected resources
* Task CRUD operations
* Task status management
* RESTful API endpoints
* GraphQL API
* Hotwire-powered UI
* Turbo for navigation and partial page updates
* Stimulus for client-side interactions
* PostgreSQL database
* RSpec test suite
* Docker and Docker Compose support
* Rails security best practices
* Form validations and error handling

## 🛠️ Tech Stack

| Category    | Technologies                           |
| ----------- | -------------------------------------- |
| Language    | Ruby 3.4.5                             |
| Framework   | Ruby on Rails 8.1.3.1                  |
| Database    | PostgreSQL 18                          |
| Frontend    | Hotwire, Turbo, Stimulus, Tailwind CSS |
| APIs        | REST, GraphQL                          |
| Testing     | RSpec                                  |
| Development | Docker, Docker Compose                 |
| Server      | Puma                                   |

## 🏗️ Architecture

The application follows the Rails MVC architecture while exposing both REST and GraphQL APIs.

```text
                        ┌──────────────┐
                        │    Client    │
                        │ Browser/API  │
                        └──────┬───────┘
                               │
                 ┌─────────────┴─────────────┐
                 │                           │
          HTML / Hotwire               API Clients
                 │                           │
                 ▼                    ┌──────┴──────┐
        ┌────────────────┐             │             │
        │    Rails       │          REST API     GraphQL
        │  Controllers   │             │             │
        └───────┬────────┘             └──────┬──────┘
                │                             │
                └─────────────┬───────────────┘
                              ▼
                     ┌─────────────────┐
                     │ Business Logic  │
                     │   & Models      │
                     └────────┬────────┘
                              │
                              ▼
                     ┌─────────────────┐
                     │   PostgreSQL    │
                     └─────────────────┘
```

The UI remains primarily server-rendered using Rails and Hotwire rather than requiring a separate SPA frontend.

## 🔐 Authentication & Authorization

Authentication is implemented using Rails session-based authentication.

The application supports:

* User registration
* Password authentication
* Login and logout
* Session management
* Protected resources
* Unauthenticated access handling
* User-specific resource authorization

Protected controller actions require an authenticated session, while registration and login remain publicly accessible.

## 📋 Task Management

Authenticated users can:

* Create tasks
* View tasks
* Edit tasks
* Delete tasks
* Update task status
* Manage their own tasks

Example task lifecycle:

```text
Pending → In Progress → Completed
```

Authorization ensures that users cannot access or modify tasks belonging to other users.

## ⚡ Hotwire

The application uses **Hotwire** to provide interactive behavior without building a traditional JavaScript SPA.

### Turbo

Used for:

* Fast navigation
* Partial page updates
* Form submissions
* Turbo Frames
* Dynamic UI updates

### Stimulus

Used for lightweight client-side behavior such as:

* Modal interactions
* UI state management
* Form interactions
* Dynamic task operations

This keeps JavaScript focused on UI behavior while application logic remains on the Rails side.

## 🔌 REST API

The application follows conventional RESTful API design.

Example task endpoints:

```text
GET    /tasks
POST   /tasks
GET    /tasks/:id
PATCH  /tasks/:id
DELETE /tasks/:id
```

The API uses appropriate HTTP methods and response status codes for successful and unsuccessful operations.

## 🕸️ GraphQL API

The application exposes a GraphQL endpoint at:

```text
POST /graphql
```

GraphiQL is available at:

```text
http://localhost:3000/graphiql
```

GraphQL requests require an authenticated user session.

### 1. List Tasks

Fetch all tasks belonging to the authenticated user.

```graphql
query {
  tasks {
    id
    title
    description
    status
    priority
  }
}
```

Example response:

```json
{
  "data": {
    "tasks": [
      {
        "id": "2",
        "title": "Updated GraphQL task",
        "description": "Updated through GraphQL",
        "status": "in_progress",
        "priority": "medium"
      },
      {
        "id": "1",
        "title": "Task 1",
        "description": "Task 1",
        "status": "pending",
        "priority": "medium"
      }
    ]
  }
}
```

### 2. Create Task

Create a new task for the authenticated user.

```graphql
mutation {
  createTask(
    input: {
      input: {
        title: "Test GraphQL task"
        description: "Created through GraphQL"
        status: PENDING
        priority: HIGH
      }
    }
  ) {
    task {
      id
      title
      description
      status
      priority
    }
    errors
  }
}
```

Example response:

```json
{
  "data": {
    "createTask": {
      "task": {
        "id": "2",
        "title": "Test GraphQL task",
        "description": "Created through GraphQL",
        "status": "pending",
        "priority": "high"
      },
      "errors": []
    }
  }
}
```

### 3. Update Task

Update an existing task belonging to the authenticated user.

```graphql
mutation {
  updateTask(
    input: {
      id: "2"
      input: {
        title: "Updated GraphQL task"
        description: "Updated through GraphQL"
        status: IN_PROGRESS
        priority: MEDIUM
      }
    }
  ) {
    task {
      id
      title
      description
      status
      priority
    }
    errors
  }
}
```

Example response:

```json
{
  "data": {
    "updateTask": {
      "task": {
        "id": "2",
        "title": "Updated GraphQL task",
        "description": "Updated through GraphQL",
        "status": "in_progress",
        "priority": "medium"
      },
      "errors": []
    }
  }
}
```

### GraphQL Operations

| Operation | GraphQL      | Description                              |
| --------- | ------------ | ---------------------------------------- |
| List      | `tasks`      | Returns tasks for the authenticated user |
| Create    | `createTask` | Creates a new task                       |
| Update    | `updateTask` | Updates an existing task                 |

### Running GraphQL Locally

Start the application with Docker:

```bash
docker compose up
```

Then open:

```text
http://localhost:3000/graphiql
```

GraphQL provides clients with a flexible way to request only the fields required by the client.

## 🗄️ PostgreSQL

PostgreSQL is used as the primary relational database.

The project demonstrates:

* Active Record associations
* Database migrations
* Model validations
* Database constraints
* Indexing
* Relational data modeling

## 🐳 Docker

The application is fully containerized using Docker and Docker Compose.

The development environment separates the Rails application and PostgreSQL database into containers.

### Start the application

```bash
docker compose up --build
```

The application will be available at:

```text
http://localhost:3000
```

### Run Rails commands

```bash
docker compose exec web bin/rails console
```

```bash
docker compose exec web bin/rails db:migrate
```

### Run the test suite

```bash
docker compose exec web bundle exec rspec
```

## 🧪 Testing

RSpec is used for automated testing.

The test suite covers:

* Model behavior
* Validations
* User registration
* Authentication
* Authorization
* Task CRUD operations
* Request behavior
* API responses
* Error scenarios

Run all tests:

```bash
docker compose exec web bundle exec rspec
```

Run a specific spec:

```bash
docker compose exec web bundle exec rspec spec/requests/users_spec.rb
```

## 🔒 Security

The application follows Rails security conventions, including:

* CSRF protection
* Strong parameters
* Password hashing
* Session-based authentication
* Authorization checks
* Protected controller actions
* Model validations
* Database constraints

Security is treated as part of the application design rather than as an afterthought.

## 📁 Project Structure

```text
task_manager/
├── app/
│   ├── controllers/
│   ├── models/
│   ├── views/
│   ├── javascript/
│   │   └── controllers/
│   └── graphql/
│
├── config/
│   ├── routes.rb
│   └── database.yml
│
├── db/
│   ├── migrate/
│   └── schema.rb
│
├── spec/
│   ├── models/
│   ├── requests/
│   └── ...
│
├── Dockerfile
├── docker-compose.yml
├── Gemfile
└── README.md
```

## 🚀 Getting Started

### Prerequisites

The easiest way to run the project is with:

* Docker
* Docker Compose

For running Rails directly:

* Ruby 3.4.5
* Rails 8.1.3.1
* PostgreSQL 18

### Clone the repository

```bash
git clone https://github.com/shivamkolli/task_manager.git
cd task_manager
```

### Start the application

```bash
docker compose up --build
```

Visit:

```text
http://localhost:3000
```

## 💡 Engineering Concepts Demonstrated

This project focuses on practical implementation of:

* Rails MVC
* RESTful API design
* GraphQL API design
* Authentication
* Authorization
* Session management
* Hotwire architecture
* Turbo Frames
* Stimulus controllers
* PostgreSQL data modeling
* Active Record
* Strong parameters
* Rails security
* Automated testing with RSpec
* Dockerized development
* Separation of concerns
* Maintainable application structure
* API error handling

## 🎯 Project Objective

The objective of this project is to demonstrate how a modern Rails application can be designed and developed with:

**Clean architecture + secure authentication + multiple API interfaces + modern Rails UI + automated testing + containerized development.**

It provides a practical example of building a production-oriented Rails application while keeping the architecture simple and maintainable.

## 🔮 Future Improvements

Potential extensions include:

* Background processing with Sidekiq
* Redis caching
* Pagination
* Search and filtering
* Real-time updates
* API versioning
* Advanced GraphQL authorization
* Observability and structured logging
* CI/CD pipeline
* Cloud deployment

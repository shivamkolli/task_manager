# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


## GraphQL API

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

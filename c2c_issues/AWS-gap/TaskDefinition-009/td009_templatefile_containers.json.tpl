[
  {
    "name": "app",
    "image": "${image}",
    "essential": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "c2cgap-td009-templatefile",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "app"
      }
    }
  }
]

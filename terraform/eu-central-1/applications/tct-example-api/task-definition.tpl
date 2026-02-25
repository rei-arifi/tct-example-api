[
  {
    "name": "api",
    "image": "0rxa/tct-example-api:1.1.0",
    "cpu": 256,
    "memory": 256,
    "memoryReservation": 256,
    "portMappings": [
      {
        "containerPort": ${container_port},
        "protocol": "tcp"
      }
    ],
    "essential": true,
    "environment": [
      {
        "name": "PORT",
        "value": "${container_port}"
      }
    ],
    "healthCheck": {
      "command": [
        "CMD-SHELL",
        "curl -f http://127.0.0.1:${container_port}/health/live || exit 1"
      ],
      "interval": 5,
      "timeout": 2,
      "retries": 3,
      "startPeriod": 10
    }
  }
]
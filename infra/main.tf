terraform{
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" { 
    region = "sa-east-1"
}

# IAM


# SNS
resource "aws_sns_topic" "tickets"{
    name = "zendesk-tickets-topic"   
}

# SQS
resource "aws_sqs_queue" "tickets_queue" {
    name = "zendesk-tickets-queue"
}


# SNS Subscription
resource "aws_sns_topic_subscription" "tickets_queue_to_topic" {
    topic_arn = aws_sns_topic.tickets.arn
    protocol = "sqs"
    endpoint = aws_sqs_queue.tickets_queue.arn
}

# S3
resource "aws_s3_bucket" "s3_bucket_raw"{
    bucket = "atendimento-tickets-raw"
    acl = "private"
}

resource "aws_s3_bucket" "s3_bucket_processed"{
    bucket = "atendimento-tickets-processed"
    acl = "private"
}

resource "aws_s3_bucket" "s3_bucket_curated"{
    bucket = "atendimento-tickets-curated"
    acl = "private"
}
terraform{
    required_providers {
        aws = {
            source = "hasicorp/aws"
        }
    }
}

provider "aws" { 
    region = sa-east-1
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
    endponit = aws_sqs_queue.tickets_queue.arn
}

# S3
resource "aws_s3_bucket" "s3_bucket_raw"{
    name = "atendimento-tickets-raw"
}

resource "aws_s3_bucket" "s3_bucket_processed"{
    name = "atendimento-tickets-processed"
}

resource "aws_s3_bucket" "s3_bucket_curated"{
    name = "atendimento-tickets-curated"
}
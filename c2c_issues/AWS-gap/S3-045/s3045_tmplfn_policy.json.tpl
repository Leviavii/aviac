{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CrossAccountRead",
      "Effect": "Allow",
      "Principal": { "AWS": "arn:aws:iam::033677994240:root" },
      "Action": "s3:GetObject",
      "Resource": "${bucket_arn}/*"
    }
  ]
}

# Terraform for glenwinters.com 

This repo holds the Terraform that defines the AWS infrastructure for my
personal website. See [glenwinters/glenwinters.com][1] for the website's code.

The DNS names glenwinters.com and www.glenwinters.com point to a CloudFront
distribution, which serves the website on HTTP and HTTPS using an S3 static
website as the origin.

[1]: https://github.com/glenwinters/glenwinters.com

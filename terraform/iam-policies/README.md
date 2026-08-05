// Bootstrap Policy
// Used only once to create:
// 1. S3 Backend Bucket
// 2. DynamoDB Lock Table
//TerraformBackendPolicy

//Purpose:
//- Used only during bootstrap.
//- Creates S3 backend bucket.
//- Creates DynamoDB lock table.
//- After bootstrap, this policy should be reduced to least privilege.
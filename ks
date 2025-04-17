Hello Dave,

Thanks for your patience.The error you are experiencing:

- Project `793331946734` is not permitted to use Publisher Model .
is occurring because your access token — which is being used in the API call — is bound to the project VerificAIExperimentation (project number: 793331946734) rather than the storied-store-450000-b8 project as your curl example suggests.

- Though you are passing PROJECT_ID="storied-store-450000-b8", model access is checked by Google on the project to which the access token is bound, not on the string that you are passing in the request body.


Step-1: 
- Use storied-store-450000-b8 for MAAS Model Access
If storied-store-450000-b8 already has access to MAAS models like llama-3.1, you can generate an access token under that project and retry the request.

Steps:


gcloud config set project storied-store-450000-b8
gcloud auth print-access-token
Then re-run your curl call using that token:


curl \
  -X POST \
  -H "Authorization: Bearer <access-token-from-above>" \
  -H "Content-Type: application/json" \
  https://us-central1-aiplatform.googleapis.com/v1/projects/storied-store-450000-b8/locations/us-central1/endpoints/openapi/chat/completions \
  -d '{"model":"meta/llama-4-scout-17b-16e-instruct-maas","messages":[{"role":"user","content":"Summer travel plan to Paris"}]}'


Option 2: Request Model Access for VerificAIExperimentation
If your team prefers or needs to work within VerificAIExperimentation, then that project must be explicitly allowed to use Meta’s MAAS models such as:

meta/llama-4-scout-17b-16e-instruct-maas

meta/llama-3.2-* models

Steps:

Submit a support request to Google Cloud.

Ask them to grant MAAS model access for:

Project number: 793331946734

Region: us-central1

Publisher project: meta / projects/793331946734



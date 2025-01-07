import os
import json
from openai import AzureOpenAI

# Retrieve environment variables from Azure DevOps pipeline variables
# Assuming the variables are set in the pipeline as AZURE_OPENAI_API_KEY and AZURE_OPENAI_ENDPOINT
api_key = os.getenv("AZURE-OPENAI-API-KEY")
azure_endpoint = os.getenv("AZURE-OPENAI-ENDPOINT")

# Check if the environment variables are set, raise an error if not
if not api_key or not azure_endpoint:
    raise ValueError("Azure OpenAI API key and endpoint must be set in the environment variables.")

# Set the environment variables for the Azure OpenAI client
os.environ["AZURE_OPENAI_API_KEY"] = api_key
os.environ["AZURE_OPENAI_ENDPOINT"] = azure_endpoint

# Initialize the Azure OpenAI client with the API key and endpoint
client = AzureOpenAI(
    api_key=os.environ["AZURE_OPENAI_API_KEY"],
    azure_endpoint=os.environ["AZURE_OPENAI_ENDPOINT"],
    api_version="2024-05-01-preview",  # Specify the API version to use
)

# Create an assistant for CI/CD troubleshooting
assistant = client.beta.assistants.create(
    name="CI/CD Troubleshooting Assistant",  # Name of the assistant
    instructions="You are an AI assistant that analyzes CI/CD pipeline errors and suggests solutions.",  # Instructions for the assistant
    tools=[{"type": "code_interpreter"}],  # Add tools if necessary, e.g., [{"type": "code_interpreter"}]
    model="gpt-4o-kaan-demo",  # Replace with your deployed model's name
)

# Create a thread for the conversation
thread = client.beta.threads.create()

# Read and parse pipeline_error from a JSON file
with open('error_log.json', 'r') as file:
    error_data = json.load(file)  # Load the JSON data from the file
    pipeline_error = error_data['pipeline_error']['message']  # Extract the pipeline error message
    failed_build_link = error_data['pipeline_error']['failed_build_link']  # Extract the failed build link

# Add a user error message to the thread
message = client.beta.threads.messages.create(
    thread_id=thread.id,  # ID of the thread
    role="user",  # Role of the message sender
    content=f"Analyze the following CI/CD pipeline error and provide a potential cause and solution in the following format: error explanation, error cause, error solution: \"{pipeline_error}\""  # Content of the message
)

# Run the thread and poll for the result
run = client.beta.threads.runs.create_and_poll(
    thread_id=thread.id,  # ID of the thread
    assistant_id=assistant.id,  # ID of the assistant
    instructions="Provide concise and actionable insights. Include any relevant debugging steps."  # Instructions for the assistant
)

# Define output file
output_file = "output.json"

# Check if the run is completed
if run.status == "completed":
    # Retrieve and save the assistant's response
    messages = client.beta.threads.messages.list(thread_id=thread.id)  # List all messages in the thread
    assistant_output = {
        "assistant_output": {
            "error_explanation": "",  # Placeholder for error explanation
            "error_cause": "",  # Placeholder for error cause
            "error_solution": "",  # Placeholder for error solution
            "failed_build_link": failed_build_link  # Include the failed build link
        }
    }
    # Iterate through the messages to find the assistant's response
    for msg in messages:
        if msg.role == "assistant":
            content = msg.content  # Get the content of the message
            if isinstance(content, list):
                content = "\n".join(str(item) for item in content)  # Join list items into a single string
            content = str(content)  # Convert content to string
            # Parse the content to extract explanation, cause, and solution
            if "**Error Explanation:**" in content:
                explanation_start = content.find("**Error Explanation:**") + len("**Error Explanation:**")
                cause_start = content.find("**Error Cause:**")
                solution_start = content.find("**Error Solution:**")
                assistant_output["assistant_output"]["error_explanation"] = content[explanation_start:cause_start].strip().replace("\\n", "\n").replace("\\'", "'")
                assistant_output["assistant_output"]["error_cause"] = content[cause_start + len("**Error Cause:**"):solution_start].strip().replace("\\n", "\n").replace("\\'", "'")
                assistant_output["assistant_output"]["error_solution"] = content[solution_start + len("**Error Solution:**"):].strip().replace("\\n", "\n").replace("\\'", "'")
    # Write the assistant's output to a JSON file
    with open(output_file, "w") as file:
        json.dump(assistant_output, file, indent=4)
    print(f"Output has been written to {output_file}")
else:
    # Handle the case where the run did not complete successfully
    assistant_output = {
        "assistant_output": {
            "error_explanation": "",  # Placeholder for error explanation
            "error_cause": "",  # Placeholder for error cause
            "error_solution": "Run failed or did not complete.",  # Indicate that the run failed
            "failed_build_link": failed_build_link  # Include the failed build link
        }
    }
    # Write the assistant's output to a JSON file
    with open(output_file, "w") as file:
        json.dump(assistant_output, file, indent=4)
    print("Run failed or did not complete. Output saved to output.json")
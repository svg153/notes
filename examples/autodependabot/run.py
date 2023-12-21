import os
from jinja2 import Template

# Define the mapping of file types to package ecosystems
file_ecosystem_mapping = {
    "package.json": "npm",
    "requirements.txt": "pip",
    "Gemfile": "rubygems",
    # Add more mappings as needed
}

# Define the data to populate the template
updates = []

# Iterate over the project directories
for root, dirs, files in os.walk("."):
    for file in files:
        file_path = os.path.join(root, file)
        for file_type, package_ecosystem in file_ecosystem_mapping.items():
            if file.endswith(file_type):
                updates.append({
                    "package_ecosystem": package_ecosystem,
                    "directory": os.path.dirname(file_path),
                })

# Define the template
template = """
# To get started with Dependabot version updates, you'll need to specify which
# package ecosystems to update and where the package manifests are located.
# 

version: 2
updates:
{% for update in updates %}
  - package-ecosystem: "{{ update.package_ecosystem }}"
    directory: "{{ update.directory }}"
    schedule:
      interval: "weekly"
      day: "wednesday"
    labels:
      - "dependencies"
{% endfor %}
"""

# Load the template
template = Template(template)

# Render the template with the data
rendered_file = template.render(updates=updates)

# Save the rendered file
with open("dependabot.yml", "w") as file:
    file.write(rendered_file)

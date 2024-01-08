# generate admin config for simple-updates
# config:
#   labels:
#     - dependencies
#   schedule:
#     interval: "weekly"
#     day: "wednesday"
# groups:
#   - package-ecosystem: github-actions
#     repos:
#       admin: <list_of_folders_in_actions>


file_path="./admin.yaml"

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))

# generate the list_of_folders_in_actions
actions_dir = os.path.join(SCRIPT_DIR, "../../actions/")
# list_of_folders_in_actions

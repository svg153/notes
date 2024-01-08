import yaml
import argparse

class DependabotConfig:
    """
    Represents the full Dependabot configuration.
    """
    def __init__(self, config):
        self.config = config['config']
        self.groups = config['groups']

    def generate_updates(self, package_ecosystem, repos):
        """
        Generates a list of updates for the specified group.
        """
        updates = []
        for repo, directories in repos.items():
            if directories:
                for directory in directories:
                    updates.append({
                        'package-ecosystem': package_ecosystem,
                        'directory': directory,
                        'schedule': self.config['schedule'],
                        'labels': self.config['labels']
                    })
            else:
                updates.append({
                    'package-ecosystem': package_ecosystem,
                    'directory': '/',
                    'schedule': self.config['schedule'],
                    'labels': self.config['labels']
                })
        return updates

    def generate_dependabot_config(self):
        """
        Generates the full Dependabot configuration file.
        """
        # Generate a list of updates for each group
        updates = []
        for group in self.groups:
            package_ecosystem = group['package-ecosystem']
            repos = group['repos']
            updates.extend(self.generate_updates(package_ecosystem, repos))

        # Generate the full Dependabot configuration file
        dependabot_config = {
            'version': 2,
            'updates': updates
        }
        return dependabot_config

    def save(self, filename):
        """
        Saves the full Dependabot configuration file to disk.
        """
        dependabot_config = self.generate_dependabot_config()
        with open(filename, 'w') as f:
            yaml.dump(dependabot_config, f)

if __name__ == '__main__':
    print(1)
    # Take configuration file from the command line arguments with argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('config', help='Path to the configuration file')
    args = parser.parse_args()

    # Load the configuration file
    with open(args.config, 'r') as f:
        config = yaml.safe_load(f)

    # Create a DependabotConfig object
    dependabot_config = DependabotConfig(config)

    # Save the full Dependabot configuration file to disk
    dependabot_config.save('dependabot.yml')
    print(3)

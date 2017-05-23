import argparse
import os.path
import subprocess

def parse_channels(home_dir = "."):
    """
    Parses out all the channels and their YAML files, recursively starting
    from the provided directory.

    Parameters
    ----------
    home_dir : string
        Path indicating where to start in parsing out YAML files.

    Returns
    -------
    retval : dictionary
        Key/value pairs, indicating channel name / yaml path.
    """
    start = os.path.abspath(home_dir)
    yamls = []
    for root, dirs, files in os.walk(start):
        to_add = filter(lambda x: x.endswith("yml") or x.endswith("yaml"), files)
        yamls.extend(map(lambda x: (x.split(".")[0], os.path.join(root, x)), to_add))
    return dict(yamls)

def update_channel(channel_name, yaml_path, py_version):
    """
    Runs a conda-env update given a new YAML file.

    Parameters
    ----------
    channel_name : string
        The name of the channel to update (e.g. "defaults", "conda-forge").
    yaml_path : string
        The full (absolute or relative to this script) path to the yaml file.
    py_version : int
        Integer version of Python this environment update should enforce.

    Returns
    -------
    CalledProcessError if something went wrong, None otherwise.
    """
    cmd = ["conda", "env", "update", "-n", channel_name,
        "-f", yaml_path, "python={}".format(py_version)]

    try:
        subprocess.run(cmd, check = True)
    except subprocess.CalledProcessError as e:
        return e

    # Nothing really to return if it's successful, but we'll return something.
    return None

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', '--version', required = True, type = int,
        choices = [2, 3], help = 'Python version. If 2, a separate env is created.')
    parser.add_argument('-p', '--prefix', required = True,
        help = 'Install prefix for this distribution.')
    parser.add_argument('-o', '--os', required = True, choices = ["Linux", "MacOSX"],
        help = 'Host operating system.')
    args = vars(parser.parse_args())

    # First, what are we even installing?
    environments = parse_channels()

    # Second, let's make sure the environment is correct.
    if args['version'] == 2:
        try:
            subprocess.run(["source", "activate", "py2"])
        except subprocess.CalledProcessError as e:
            quit("Something went wrong switching to the py2 environment: {}".format(e))

    # Iterate through the yaml files (corresponding to channels), and install.
    for channel, yaml in environments.items():
        ret = update_channel(channel, yaml, args['version'])
        if ret is not None:
            quit("ERROR! Something went wrong in configuring \"{}\":\n\n {}"
                .format(channel, ret))

    # All done! Switch out of the py2 env if we need to, otherwise that's it.
    # Second, let's make sure the environment is correct.
    if args['version'] == 2:
        try:
            subprocess.run(["source", "deactivate"])
        except subprocess.CalledProcessError as e:
            quit("Something went wrong switching out of the py2 environment: {}".format(e))

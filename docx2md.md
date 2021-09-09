# docx2md

Simple and fasts steps to convert docx files into markdown files.

## Requirements

- Docker

## Steps

1. Save your file into odt format
2. Create a new empty folder and move your file into it
3. Create the converter script:

    ```bash
    echo """
    #!/bin/sh
    pandoc file.odt -o file.html
    pandoc file.html -o file.md
    rm file.html
    """ > con.sh
    ```

4. Run this command:

    ```bash
    docker run \
      --rm \
      --name docx2md \
      --user $(id -u):$(id -g) \
      --volume "$(pwd):/data" \
      --entrypoint "/data/con.sh" \
      pandoc/latex:2.6 \
        file.odt
    ```

5. The converted file "file.md" will be in the same folder.

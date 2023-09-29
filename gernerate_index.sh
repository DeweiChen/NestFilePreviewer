#!/bin/bash

# Define the output HTML file
output_html="nestFilePreviewer.html"

# Write the HTML header to the output file
cat <<EOF > "$output_html"
<!DOCTYPE html>
<html>
<head>
    <title>NestFilePreviewer</title>
        <style>
            /* Style for the figure and figcaption elements */
            figure {
                display: inline-block;
                text-align: center;
            }
            figcaption {
                padding: 12px;
                font-size: 16px;
            }
            /* Style for the container div */
            .image-container {
                text-align: center; /* Center aligns the image horizontally */
                display: flex;
                justify-content: center; /* Center aligns the image vertically */
                align-items: center;
                height: 240px; /* Set the desired height for the container */
                border: 1px solid #ccc; /* Optional border for the container */
            }

            /* Style for the image */
            .scaled-image {
                max-width: 100%; /* Ensure the image doesn't exceed the container's width */
                max-height: 100%; /* Ensure the image doesn't exceed the container's height */
            }
        </style>
</head>
<body>
    <h1>NestFilePreviewer</h1>
EOF

# Use the find command to generate a list of image files and process them
find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | while IFS= read -r image_path; do
    result=$(echo "$image_path" | sed 's/^.\///')
    # Append an <img> tag with the file URI to the HTML file
    echo "  <figure>" \
         "    <figcaption>$result</figcaption>" \
         "    <div class="image-container">" \
         "      <img class="scaled-image" src=\"$result\" alt=\"$result\" title=\"$result\">" \
         "    </div>" \
         "  </figure>" >> "$output_html"
done

# Write the closing HTML tags to the output file
cat <<EOF >> "$output_html"
</body>
</html>
EOF

echo "HTML file generated: $output_html"

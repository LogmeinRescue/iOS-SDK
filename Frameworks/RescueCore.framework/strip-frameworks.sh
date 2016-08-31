function codesign {
	if [ "${CODE_SIGNING_REQUIRED}" == "YES" ]; then
    	echo "Code signing $1, identity: ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
    	/usr/bin/codesign --force --sign "$EXPANDED_CODE_SIGN_IDENTITY" --preserve-metadata=identifier,entitlements "$1"
	fi
}

function strip {
    binary="$1"
    archs=$(lipo -info "$binary" | rev | cut -d ':' -f1 | rev)
    removed_archs=""
    for arch in $archs; do
        if [[ "$VALID_ARCHS" != *"$arch"* ]]; then
            # Remove unnecessary architectures
            lipo -remove "$arch" -output "$binary" "$binary" || exit 1
            removed_archs="$removed_archs $arch"
        fi
    done
    echo "$removed_archs"
}

echo "Stripping frameworks"
cd "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"

for file in $(find . -type f -perm +111); do
  # Skip non-dynamic libraries
  if [[ "$(file "${file}")" != *"dynamically linked shared library"* ]]; then
    continue
  fi

  stripped=$(strip "$file")

  if [[ "$stripped" != "" ]]; then
  	echo "Stripped ${stripped} from ${file}"
  	codesign "$file"
  fi
done
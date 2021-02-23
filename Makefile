board=nice_nano
keymap=default
shield=besom
config_dir=/home/okke/dev/keymap-besom/config
zmk_dir=/home/okke/dev/zmk/app


.PHONY: build-left build-left-config build-right build-right-config flash

build-left:
	cd ${zmk_dir} && west build -b ${board} -d build/${shield}_left --pristine -- -DSHIELD=${shield}_left -DKEYMAP=${keymap} -DZMK_CONFIG=${config_dir}

build-right:
	cd ${zmk_dir} && west build -b ${board} -d build/${shield}_right --pristine -- -DSHIELD=${shield}_right -DKEYMAP=${keymap} -DZMK_CONFIG=${config_dir}

flash-left: ${zmk_dir}/build/${shield}_left/zephyr/zmk.uf2
	printf "Put device in dfu mode"
	while [ ! -f /media/${USER}/NICENANO/current.uf2 ]; do sleep 1; printf "."; done; printf "\n"
	cp ${zmk_dir}/build/${shield}_left/zephyr/zmk.uf2 /media/${USER}/NICENANO/

flash-right: 
	printf "Put device in dfu mode"
	while [ ! -f /media/${USER}/NICENANO/current.uf2 ]; do sleep 1; printf "."; done; printf "\n"
	cp ${zmk_dir}/build/${shield}_right/zephyr/zmk.uf2 /media/${USER}/NICENANO/

clean:
	rm -rf ./build
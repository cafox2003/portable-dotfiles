if status is-interactive
    # Commands to run in interactive sessions can go here
end

#fish_vi_key_bindings
#bind \ce complete

alias b "cd .. && ls"

fish_vi_key_bindings
bind --mode insert \ce accept-autosuggestion

set CS3214_HOME /home/courses/cs3214

set -g fish_greeting ""

# Clear old additions to PATH just in case
set -e PATH

# Add CS3214 bin to PATH first, then standard directories
set -gx PATH /home/ugrads/majors/calebf24/bin /usr/share/Modules/bin /home/courses/cs3214/bin /usr/local/bin /usr/bin /bin /usr/sbin /sbin /var/lib/snapd/snap/bin /home/ugrads/majors/calebf24/.cargo/bin /web/courses/cs4284/pintostools/bin



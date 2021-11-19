## --------------------------------------------------------------
## |                       waitFor* macros                      |
## --------------------------------------------------------------



# #{ waitForSimulation()

waitForSimulation() {
  until timeout 6s rostopic echo /gazebo/model_states -n 1 --noarr > /dev/null 2>&1; do
    echo "waiting for simulation"
    sleep 1;
  done
  sleep 1;
}

# #{ waitForMoveit()

waitForMoveit() {
  until timeout 6s rostopic echo /move_group/status -n 1 --noarr > /dev/null 2>&1; do
    echo "waiting for move_group"
    sleep 1;
  done
  sleep 1;
}
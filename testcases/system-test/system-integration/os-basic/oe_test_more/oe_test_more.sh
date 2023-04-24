#!/usr/bin/bash

# Copyright (c) 2022. Huawei Technologies Co.,Ltd.ALL rights reserved.
# This program is licensed under Mulan PSL v2.
# You can use it according to the terms and conditions of the Mulan PSL v2.
#          http://license.coscl.org.cn/MulanPSL2
# THIS PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
# EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
# MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
# See the Mulan PSL v2 for more details.


source ${OET_PATH}/libs/locallibs/common_lib.sh

function pre_test() {
    LOG_INFO "Start environment preparation."
    ls /tmp/test && rm -rf /tmp/test
    for ((i=1;i<=100;i+=1))
    do
        echo $i >> /tmp/test
    done
    LOG_INFO "End of environmental preparation!"
}

function run_test() {
    LOG_INFO "Start to run test."
    echo q | more /tmp/test >testlog
    CHECK_RESULT $? 0 0 "Failed to execute more"
    test -s testlog && grep "/tmp/test" testlog
    CHECK_RESULT $? 0 0 "output log error"
    more +2 /tmp/test | grep -w 0
    CHECK_RESULT $? 0 1 "specifies the number of lines to display failed"
    LOG_INFO "End to run test."
}

function post_test() {
    LOG_INFO "Start to restore the test environment."
    rm -rf testlog /tmp/test
    LOG_INFO "End to restore the test environment."
}

main "$@"
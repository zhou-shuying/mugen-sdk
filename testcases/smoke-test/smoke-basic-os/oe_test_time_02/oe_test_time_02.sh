#!/usr/bin/bash

# Copyright (c) 2022. Huawei Technologies Co.,Ltd.ALL rights reserved.
# This program is licensed under Mulan PSL v2.
# You can use it according to the terms and conditions of the Mulan PSL v2.
#          http://license.coscl.org.cn/MulanPSL2
# THIS PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
# EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
# MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
# See the Mulan PSL v2 for more details.

# #############################################
# @Author    :   liujingjing
# @Contact   :   liujingjing25812@163.com
# @Date      :   2022/06/20
# @License   :   Mulan PSL v2
# @Desc      :   Test /usr/bin/time
# ############################################

source ${OET_PATH}/libs/locallibs/common_lib.sh

function pre_test() {
    LOG_INFO "Start to prepare the test environment."
    DNF_INSTALL time
    LOG_INFO "End to prepare the test environment."
}

function run_test() {
    LOG_INFO "Start to run test."
    /usr/bin/time -o testlog dd if=/dev/zero of=/dev/null count=1 ibs=50M
    CHECK_RESULT $? 0 0 "Failed to execute time -o"
    grep pagefaults testlog && rm -rf testlog
    CHECK_RESULT $? 0 0 "Failed to find testlog"
    /usr/bin/time --output=testlog dd if=/dev/zero of=/dev/null count=1 ibs=50M
    CHECK_RESULT $? 0 0 "Failed to execute time --output"
    grep pagefaults testlog
    CHECK_RESULT $? 0 0 "Failed to find pagefaults"
    LOG_INFO "End to run test."
}

function post_test() {
    LOG_INFO "Start to restore the test environment."
    rm -rf testlog
    DNF_REMOVE
    LOG_INFO "End to restore the test environment."
}

main "$@"

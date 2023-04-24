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
# @Date      :   2022/07/12
# @License   :   Mulan PSL v2
# @Desc      :   Test the basic functions of maildrop
# ############################################

source ${OET_PATH}/libs/locallibs/common_lib.sh

function pre_test() {
    LOG_INFO "Start to prepare the test environment."
    DNF_INSTALL maildrop
    LOG_INFO "End to prepare the test environment."
}

function run_test() {
    LOG_INFO "Start to run test."
    echo hello | maildrop -V 10 -f ${NODE1_IPV4} -d root -A "Header: value" 2>&1 | grep "maildrop:"
    CHECK_RESULT $? 0 0 "Service not started"
    grep -A 5 "Header: value" /var/mail/root | grep hello
    CHECK_RESULT $? 0 0 "Failed to display hello"
    LOG_INFO "End to run test."
}

function post_test() {
    LOG_INFO "Start to restore the test environment."
    rm -rf /var/mail/root
    DNF_REMOVE
    rm -rf /etc/yum.repos.d/openeuler.repo
    LOG_INFO "End to restore the test environment."
}

main "$@"

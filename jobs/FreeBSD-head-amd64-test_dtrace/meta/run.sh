#!/bin/sh

METADIR=/tmp/meta
sh -ex ${METADIR}/disable-zfs-tests.sh

cd /usr/tests/cddl/usr.sbin/dtrace
set +e
/usr/local/bin/kyua test
rc=$?
set -e
if [ ${rc} -ne 0 ] && [ ${rc} -ne 1 ]; then
	exit ${rc}
fi

/usr/local/bin/kyua report --verbose --results-filter passed,skipped,xfail,broken,failed --output test-report.txt
/usr/local/bin/kyua report-junit --output=test-report.xml
mv test-report.* ${METADIR}

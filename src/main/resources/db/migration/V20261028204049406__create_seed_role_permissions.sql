INSERT INTO role_permissions (
    id,
    role_id,
    permission_id
)
SELECT
    v.id::UUID,
    r.id,
    p.id
FROM (
    VALUES
        (
            '019a2a30-1000-7000-8000-000000000001',
            'PLAN_MANAGE'
        ),
        (
            '019a2a30-1000-7000-8000-000000000002',
            'WORKFLOW_COORDINATE'
        ),
        (
            '019a2a30-1000-7000-8000-000000000003',
            'DEADLINE_MANAGE'
        ),
        (
            '019a2a30-1000-7000-8000-000000000004',
            'ACCEPTANCE_PERFORM'
        ),
        (
            '019a2a30-1000-7000-8000-000000000005',
            'APPROVAL_APPROVE'
        ),
        (
            '019a2a30-1000-7000-8000-000000000006',
            'SYSTEM_CONFIGURE'
        ),
        (
            '019a2a30-1000-7000-8000-000000000007',
            'DASHBOARD_VIEW'
        ),
        (
            '019a2a30-1000-7000-8000-000000000008',
            'REPORT_VIEW'
        )
) AS v(id, permission_code)
JOIN roles r
    ON r.code = 'PTCT'
JOIN permissions p
    ON p.code = v.permission_code;

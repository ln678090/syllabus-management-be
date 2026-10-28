CREATE TABLE change_logs (
    id UUID NOT NULL,

    ke_hoach_xay_dung_id UUID NOT NULL,

    action VARCHAR(100) NOT NULL,
    description TEXT,

    changed_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_change_logs
        PRIMARY KEY (id),

    CONSTRAINT fk_change_logs_ke_hoach
        FOREIGN KEY (ke_hoach_xay_dung_id)
        REFERENCES ke_hoach_xay_dungs(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_change_logs_changed_by
        FOREIGN KEY (changed_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

CREATE INDEX idx_change_logs_ke_hoach
    ON change_logs(ke_hoach_xay_dung_id);

CREATE INDEX idx_change_logs_created_at
    ON change_logs(created_at);

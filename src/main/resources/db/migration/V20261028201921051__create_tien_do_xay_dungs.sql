CREATE TABLE tien_do_xay_dungs (
    id UUID NOT NULL,

    ke_hoach_xay_dung_id UUID NOT NULL,

    step_code VARCHAR(50) NOT NULL,
    sort_order INT NOT NULL,

    completed_at TIMESTAMPTZ,
    completed_by UUID,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_tien_do_xay_dungs
        PRIMARY KEY (id),

    CONSTRAINT fk_tdxd_ke_hoach
        FOREIGN KEY (ke_hoach_xay_dung_id)
        REFERENCES ke_hoach_xay_dungs(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_tdxd_completed_by
        FOREIGN KEY (completed_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_tdxd_ke_hoach_step
        UNIQUE (ke_hoach_xay_dung_id, step_code),

    CONSTRAINT uq_tdxd_ke_hoach_order
        UNIQUE (ke_hoach_xay_dung_id, sort_order),

    CONSTRAINT ck_tdxd_sort_order
        CHECK (sort_order > 0)
);

CREATE INDEX idx_tdxd_ke_hoach
    ON tien_do_xay_dungs(ke_hoach_xay_dung_id);

CREATE INDEX idx_tdxd_step_code
    ON tien_do_xay_dungs(step_code);

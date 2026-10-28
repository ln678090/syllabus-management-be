CREATE TABLE phan_biens (
    id UUID NOT NULL,

    ke_hoach_xay_dung_id UUID NOT NULL,
    phien_ban_de_cuong_id UUID,

    reviewer_id UUID NOT NULL,

    noi_dung TEXT,
    revision_deadline TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_phan_biens
        PRIMARY KEY (id),

    CONSTRAINT fk_phan_biens_ke_hoach
        FOREIGN KEY (ke_hoach_xay_dung_id)
        REFERENCES ke_hoach_xay_dungs(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_phan_biens_phien_ban
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_phan_biens_reviewer
        FOREIGN KEY (reviewer_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_phan_biens_ke_hoach
    ON phan_biens(ke_hoach_xay_dung_id);

CREATE INDEX idx_phan_biens_phien_ban
    ON phan_biens(phien_ban_de_cuong_id);

CREATE INDEX idx_phan_biens_reviewer
    ON phan_biens(reviewer_id);

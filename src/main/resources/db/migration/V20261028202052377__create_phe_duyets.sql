CREATE TABLE phe_duyets (
    id UUID NOT NULL,

    ke_hoach_xay_dung_id UUID NOT NULL,
    phien_ban_de_cuong_id UUID,

    action VARCHAR(50) NOT NULL,
    performed_by UUID NOT NULL,

    note TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_phe_duyets
        PRIMARY KEY (id),

    CONSTRAINT fk_phe_duyets_ke_hoach
        FOREIGN KEY (ke_hoach_xay_dung_id)
        REFERENCES ke_hoach_xay_dungs(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_phe_duyets_phien_ban
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_phe_duyets_performed_by
        FOREIGN KEY (performed_by)
        REFERENCES users(id)
        ON DELETE RESTRICT
);

CREATE INDEX idx_phe_duyets_ke_hoach
    ON phe_duyets(ke_hoach_xay_dung_id);

CREATE INDEX idx_phe_duyets_phien_ban
    ON phe_duyets(phien_ban_de_cuong_id);

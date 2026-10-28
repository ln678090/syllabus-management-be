-- Assessment - CLO Mapping
-- Lien ket thanh phan danh gia voi chuan dau ra mon hoc trong cung mot phien ban de cuong
CREATE TABLE assessment_clos (
    id UUID NOT NULL,

    phien_ban_de_cuong_id UUID NOT NULL,
    assessment_id UUID NOT NULL,
    clo_id UUID NOT NULL,

    created_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_assessment_clos
        PRIMARY KEY (id),

    CONSTRAINT fk_assessment_clos_phien_ban
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id),

    CONSTRAINT fk_assessment_clos_assessment_phien_ban
        FOREIGN KEY (
            assessment_id,
            phien_ban_de_cuong_id
        )
        REFERENCES assessments (
            id,
            phien_ban_de_cuong_id
        ),

    CONSTRAINT fk_assessment_clos_clo_phien_ban
        FOREIGN KEY (
            clo_id,
            phien_ban_de_cuong_id
        )
        REFERENCES clos (
            id,
            phien_ban_de_cuong_id
        ),

    CONSTRAINT fk_assessment_clos_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_assessment_clos
        UNIQUE (assessment_id, clo_id)
);

CREATE INDEX idx_assessment_clos_phien_ban
    ON assessment_clos(phien_ban_de_cuong_id);

CREATE INDEX idx_assessment_clos_assessment
    ON assessment_clos(assessment_id);

CREATE INDEX idx_assessment_clos_clo
    ON assessment_clos(clo_id);

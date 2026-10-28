-- Assessment - Thanh phan danh gia cua syllabus
CREATE TABLE assessments (
    id UUID NOT NULL,

    phien_ban_de_cuong_id UUID NOT NULL,

    assessment_component VARCHAR(255) NOT NULL,
    assessment_type VARCHAR(100),

    weight NUMERIC(7,4),
    part INT,

    minimum_completion_value NUMERIC(10,4),
    duration VARCHAR(100),

    question_type VARCHAR(255),
    number_of_questions VARCHAR(100),

    knowledge_skill_scope TEXT,
    grading_method TEXT,
    note TEXT,
    reference TEXT,

    sort_order INT NOT NULL,

    created_by UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_assessments
        PRIMARY KEY (id),

    CONSTRAINT fk_assessments_phien_ban_de_cuong
        FOREIGN KEY (phien_ban_de_cuong_id)
        REFERENCES phien_ban_de_cuongs(id),

    CONSTRAINT fk_assessments_created_by
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL,

    CONSTRAINT uq_assessments_phien_ban_sort_order
        UNIQUE (phien_ban_de_cuong_id, sort_order),

    CONSTRAINT uq_assessments_id_phien_ban
        UNIQUE (id, phien_ban_de_cuong_id)
);

CREATE INDEX idx_assessments_phien_ban_de_cuong
    ON assessments(phien_ban_de_cuong_id);

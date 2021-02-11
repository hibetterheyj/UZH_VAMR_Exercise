function [R, T] = pose_vector_to_transformation_matrix(pose)
    T = pose(4:6)';
    rot_vec = pose(1:3);
    theta = norm(rot_vec);
    R=axang2rotm([rot_vec/theta theta]);
end
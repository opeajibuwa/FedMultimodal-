for alpha in 5.0 0.1; do 
    for fed_alg in fed_avg fed_opt fed_prox fed_rs; do
        taskset -c 1-60 python3 train.py --alpha $alpha --hid_size 512 --sample_rate 0.3 --learning_rate 0.05  --global_learning_rate 0.004 --num_epochs 500 --en_att --att_name cross_modal --fed_alg $fed_alg --mu 0.01 --img_feat efficientnet_b0 --text_feat distilbert
    done
done

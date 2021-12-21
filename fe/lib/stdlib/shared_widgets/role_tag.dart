import 'package:fe/data/models/role.dart';
import 'package:flutter/material.dart';

class RoleTag extends StatelessWidget {
  final Role _role;
  final Function(Role)? _onRemove;

  const RoleTag({Key? key, required Role role, Function(Role)? onRemove})
      : _role = role,
        _onRemove = onRemove,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Row(
        children: [
          Text(
            _role.name,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          if (_onRemove != null)
            IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.white,
                  size: 16.0,
                ))
        ],
      ),
    );
  }
}

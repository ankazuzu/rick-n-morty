import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/character.dart';
import 'animated_favorite_button.dart';

/// Карточка персонажа
class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const CharacterCard({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение персонажа
            _buildImage(),
            
            // Информация о персонаже
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Имя и кнопка избранного
                  _buildHeader(context),
                  
                  const SizedBox(height: 6),
                  
                  // Статус и вид
                  _buildStatusRow(),
                  
                  const SizedBox(height: 4),
                  
                  // Локация
                  _buildLocationRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Изображение персонажа
  Widget _buildImage() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: CachedNetworkImage(
            imageUrl: character.image,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.error, size: 40),
            ),
          ),
        ),
        
        // Индикатор статуса
        Positioned(
          top: 8,
          left: 8,
          child: _buildStatusBadge(),
        ),
      ],
    );
  }

  /// Заголовок с именем и кнопкой избранного
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            character.name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AnimatedFavoriteButton(
          isFavorite: isFavorite,
          onPressed: onFavoriteToggle,
        ),
      ],
    );
  }

  /// Строка со статусом и видом
  Widget _buildStatusRow() {
    return Row(
      children: [
        Icon(
          _getStatusIcon(),
          size: 14,
          color: AppTheme.getStatusColor(character.status),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            '${character.status} - ${character.species}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Строка с локацией
  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 14,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            character.location.name,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Бейдж статуса
  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.getStatusColor(character.status).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        character.status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Получить иконку по статусу
  IconData _getStatusIcon() {
    switch (character.status.toLowerCase()) {
      case 'alive':
        return Icons.favorite;
      case 'dead':
        return Icons.dangerous;
      default:
        return Icons.help_outline;
    }
  }
}

